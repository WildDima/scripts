require "spec_helper"
require "movie"

describe Movie do 

  let(:movies){
      [
        {
          "url":"http://www.imdb.com/title/tt0061722/?pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=2398042102&pf_rd_r=01JPHZE595567D9ZVSJ1&pf_rd_s=center-1&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_tt_250",
          "rating":"8.0","title":"The Graduate (1967)","year":"1967",
          "duration":"106","genre":["Comedy","Drama","Romance"],
          "country":"USA","date":"1967-12-22","director":"Mike Nichols",
          "actors":"Dustin Hoffman, Anne Bancroft, Katharine Ross"
        },
        {
          "url":"http://www.imdb.com/title/tt0053779/?pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=2398042102&pf_rd_r=01JPHZE595567D9ZVSJ1&pf_rd_s=center-1&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_tt_249",
          "rating":"8.1","title":"Сладкая жизнь (1960)","year":
          "1960","duration":"174","genre":["Comedy","Drama"],
          "country":"Italy","date":"1960-02-05","director":"Federico Fellini",
          "actors":"Marcello Mastroianni, Anita Ekberg, Anouk Aimée"
        },
        {
          "url":"http://www.imdb.com/title/tt0317248/?pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=2398042102&pf_rd_r=01JPHZE595567D9ZVSJ1&pf_rd_s=center-1&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_tt_21",
          "rating":"8.7","title":"Город Бога (2002)","year":"2002",
          "duration":"130","genre":["Crime","Drama"],
          "country":"Russia","date":"2002","director":"Fernando Meirelles,",
          "actors":"Alexandre Rodrigues, Matheus Nachtergaele, Leandro Firmino"
        }
      ]
    }

  context 'Movie initialize' do

    context 'parsing params' do
      context 'with date: %Y-%m or %Y-%m-%d' do
        subject{Movie.category(movies[0], movies)}
        it{should have_attributes(
          url: "http://www.imdb.com/title/tt0061722/?pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=2398042102&pf_rd_r=01JPHZE595567D9ZVSJ1&pf_rd_s=center-1&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_tt_250",
          rating: "8.0",
          title: "The Graduate (1967)",
          year: "1967",
          duration: 106,
          genre: ["Comedy","Drama","Romance"],
          country: "USA", 
          date: Date.strptime("1967-12-22", "%Y-%m"),
          director: "Mike Nichols",
          actors: "Dustin Hoffman, Anne Bancroft, Katharine Ross"
        )}
      end

      context 'with date: %Y' do
        subject{Movie.category(movies[2], movies)}
        it{should have_attributes(
          date: Date.strptime("2002", "%Y"),
        )}
      end
    end
  end
 
  context 'Movie object method' do
    context '#description' do
      it 'should return string' do
        expect{subject(Movie.category(movies[0], movies).description).to eq("классический фильм, режиссер  %{director}, кол-во фильмов: %{director_movies_count}")}
      end
    end

    context '#to_h' do
      it 'should return hash' do
        expect{subject(Movie.category(movies[0], movies)).to_h
          .to eq({year: "1967", director: "Mike Nichols", director_movies_count: 0, actors: "Dustin Hoffman, Anne Bancroft, Katharine Ross"})}
      end
    end

    context '#method_missing' do
      it 'should return true' do
        expect{subject(Movie.category(movies[0], movies)).method_missing(:comedy).to be true}
      end

      it 'should raise error' do
        expect{subject(Movie.category(movies[0], movies)).method_missing(:asd).to raise_error}
      end

      it 'should raise ArgumentError' do
        expect{subject(Movie.category(movies[0], movies)).method_missing.to raise_error(ArgumentError)}
      end
    end
  end

end
