class CreateCarDoormirrors < ActiveRecord::Migration[5.0]
  def change
    create_table :car_doormirrors do |t|
      t.references :car_model, foreign_key: true
      t.string :openstyle, default:""
      t.string :electricwindow, default:""
      t.string :uvinterceptingglass, default:""
      t.string :privacyglass, default:""
      t.string :antipinchwindow, default:""
      t.string :skylightopeningmode, default:""
      t.string :skylightstype, default:""
      t.string :rearwindowsunshade, default:""
      t.string :rearsidesunshade, default:""
      t.string :rearwiper, default:""
      t.string :sensingwiper, default:""
      t.string :electricpulldoor, default:""
      t.string :rearmirrorwithturnlamp, default:""
      t.string :externalmirrormemory, default:""
      t.string :externalmirrorheating, default:""
      t.string :externalmirrorfolding, default:""
      t.string :externalmirroradjustment, default:""
      t.string :rearviewmirrorantiglare, default:""
      t.string :sunvisormirror, default:""

      t.timestamps
    end
  end
end
